from motor.motor_asyncio import AsyncIOMotorClient

# Change this to your MongoDB Atlas URI if hosting in the cloud
MONGO_URL = "mongodb://localhost:27017"
client = AsyncIOMotorClient(MONGO_URL)
db = client.flutter_auth_db
user_collection = db.get_collection("users")
#hi