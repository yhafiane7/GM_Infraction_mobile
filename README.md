# GM_INFRACTION Flutter Application

## Overview

GM_INFRACTION is a Flutter mobile application designed to help Moroccan communes manage infractions reported by agents. The system tracks infractions with detailed information including the violator, location, category, and subsequent decisions. The app supports full CRUD (Create, Read, Update, Delete) operations on the key entities such as Agents, Violants (violators), Communes, Categories, Decisions, and Infractions.

This app communicates with a Laravel backend API that handles data storage and business logic.

---

## Key Features

- **Agent Management:** Create, update, delete, and list agents responsible for reporting infractions.
- **Violant Management:** Manage individuals who commit infractions.
- **Commune Management:** Manage geographical administrative units (communes) with geo-coordinates.
- **Category Management:** Define and manage categories of infractions.
- **Infraction Reporting:** Report infractions with details such as location, date, category, involved agent, and violator.
- **Decision Tracking:** Record decisions related to each infraction.
- **Interactive UI:** Data tables, forms, dialogs for smooth user experience.
- **Asynchronous API communication:** Robust fetching and posting data via REST API.
- **Data validation and error handling** on input forms.

---

## Data Models

- **Agent:** Holds agent info (`id`, `nom`, `prenom`, `tel`, `cin`)
- **Violant:** Holds violator info (`id`, `nom`, `prenom`, `cin`)
- **Commune:** Represents geographical units with (`id`, `pachalikcircon`, `caidat`, `nom`, `latitude`, `longitude`)
- **Categorie:** Infraction category (`id`, `nom`, `degre`)
- **Infraction:** Infraction details with relationships (`id`, `nom`, `date`, `adresse`, `commune_id`, `violant_id`, `agent_id`, `categorie_id`, `latitude`, `longitude`)
- **Decision:** Decision related to infraction (`id`, `date`, `decisionPrise`, `infractionId`)

---

## Architecture & Components

- **Flutter Frontend:**

  - Uses `MaterialApp` with routing for navigation.
  - Screens: Home, Agent List/View, Violant List/View, Commune List/View, Category List/View, Infraction List/View, Decision List/View.
  - DataTables and Forms for CRUD operations.
  - Custom `Design` class for consistent input decorations and dialogs.

- **Service Layer:**

  - `ServiceBase` handles all REST API calls using the `http` package.
  - CRUD methods for create, read, update, delete operations.
  - Generic methods using JSON serialization/deserialization for models.

- **Models:**
  - Dart classes for each data entity with `fromJson` and `toJson` methods.

---

## Setup & Run

1. **Prerequisites:**

   - Flutter SDK installed with Dart version **>=2.19.6 <3.0.0** (e.g., Flutter 3.10.6 or 3.13.x)
   - Backend API (Laravel app) must be running and reachable
   - A physical device or emulator to run the Flutter application

2. **Clone the repository:**

   ```bash
   git clone https://github.com/yhafiane7/GM_Infraction_mobile.git
   cd GM_Infraction_mobile
   ```

3. **Install dependencies:**

   ```bash
   flutter pub get
   ```

4. **Run the app:**

   ```bash
   flutter run
   ```

---

## Screenshots / UI Preview

<p float="left">
  <img src="screenshots/Screenshot_Home.png"  height="500px" />
  <img src="screenshots/Screenshot_Agent.png"  height="500px"/>
</p>

---

## Future Improvements

- Add user authentication & roles (admin, agent)
- Map integration to display infractions geographically
- Push notifications for infractions or decisions
- Offline support and synchronization
- Enhanced error handling and logging

---

## Contribution

Contributions and suggestions are welcome. Please create issues or pull requests for improvements.

---

## Contact

For questions or support, contact me on my email hafianeyassine8@gmail.com .
