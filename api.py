import os
from fastapi import FastAPI, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
import models, auth_utils, database
from pymongo import MongoClient
from pymongo.server_api import ServerApi
from mangum import Mangum
uri = os.environ.get('MONGODB_URI')

# Create a new client and connect to the server
client = MongoClient(uri, server_api=ServerApi('1'))
# Send a ping to confirm a successful connection
try:
    client.admin.command('ping')
    print("Pinged your deployment. You successfully connected to MongoDB!")
except Exception as e:
    print(e)
#hi
app = FastAPI()

# Allows Flutter (web or mobile) to communicate with this server
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/signup")
async def signup(user: models.UserSignup):
    # Check if user exists
    if await database.user_collection.find_one({"username": user.username}):
        raise HTTPException(status_code=400, detail="Username already exists")
    
    # Hash and save
    hashed_pass = auth_utils.get_password_hash(user.password)
    new_user = {
        "username": user.username,
        "email": user.email,
        "password": hashed_pass
    }
    await database.user_collection.insert_one(new_user)
    return {"status": "success", "message": "User created"}

@app.post("/login")
async def login(user: models.UserLogin):
    db_user = await database.user_collection.find_one({"username": user.username})
    
    if not db_user or not auth_utils.verify_password(user.password, db_user["password"]):
        raise HTTPException(status_code=401, detail="Invalid credentials")
    
    return {"status": "success", "username": db_user["username"]}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)

handler = Mangum(app)
