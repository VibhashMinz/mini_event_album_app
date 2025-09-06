# 📸 Mini Event Album App  

A Flutter application built as part of the **Klikshik Flutter Developer Assignment**.  
The app demonstrates **UI design, API integration with Dio, Riverpod state management, and clean modular architecture**.  

---

## 🚀 Features  

- 🔑 **Authentication Screen** – "Continue with Google" button (simulated login with delay).  
- ⏳ **Loading State** – Loader before navigating to events.  
- 📅 **Event List** – Fetch and display events from mock API.  
- 🖼 **Albums & Photos** – Tap an event to view photos in a grid.  
- ❤️ **Photo Viewer** – Fullscreen photo with like/unlike toggle.  
- 📡 **API Integration** – Using [mockapi.io](https://mockapi.io/) with **Dio**.  
- 🛠 **State Management** – Implemented with **Riverpod**.  
- 🧪 **Unit Test (Bonus)** – Liking a photo toggles correctly.  
- 🎞 **Slideshow Mode (Bonus)** – Auto-play photos with timer.  

---

## 📂 Project Structure  

lib/
├── app/ # App-level config (theme, router, providers setup)
├── core/ # Constants, utils, Dio client
├── features/ # Feature modules (auth, events, albums, etc.)
├── photos/ # Photo-specific UI & state
└── main.dart # Entry point



---

## 🔧 Setup Instructions  

Follow these steps to run the app locally:

1. **Clone the repository**  
   
   git clone https://github.com/<your-username>/mini_event_album_app.git
   cd mini_event_album_app
2. **Install dependencies And Run App**  

    flutter pub get
    flutter run