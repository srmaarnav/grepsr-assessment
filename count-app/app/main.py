import os
from fastapi import FastAPI, Depends
from sqlalchemy import create_engine, Column, Integer
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, Session
from dotenv import load_dotenv
from sqlalchemy.orm import sessionmaker, declarative_base

# Load environment variables
load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()


# Model definition
class RequestCount(Base):
    __tablename__ = "request_count"
    id = Column(Integer, primary_key=True, index=True)
    count = Column(Integer, default=0)

# Create the table
Base.metadata.create_all(bind=engine)

app = FastAPI()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/count")
def get_request_count(db: Session = Depends(get_db)):
    count_record = db.query(RequestCount).first()
    if count_record is None:
        count_record = RequestCount(count=1)
        db.add(count_record)
    else:
        count_record.count += 1
    db.commit()
    return {"count": count_record.count}
