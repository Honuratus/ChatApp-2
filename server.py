import asyncio
import websockets
import json

async def handle_websocket(websocket, path):
    try:
        # Maintain connection with the client
        async for message in websocket:
            data = json.loads(message)
            username = data.get('username', 'Unknown')
            user_message = data.get('message', '')

            # Handle incoming messages as needed
            print(f"Received message from {username}: {user_message}")

            # Example: Broadcast the message to all connected clients
            await websocket.send(f"{username}: {user_message}")

    except websockets.exceptions.ConnectionClosedError:
        # Handle the case when the client closes the connection
        print("Connection closed")

async def broadcast(message):
    # Send the message to all connected clients
    for ws in connected_clients:
        await ws.send(message)

connected_clients = set()

if __name__ == "__main__":
    # Start the WebSocket server on port 5000
    server = websockets.serve(handle_websocket, "127.0.0.1", 5000)

    # Start the event loop
    asyncio.get_event_loop().run_until_complete(server)
    asyncio.get_event_loop().run_forever()
