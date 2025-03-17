# E-Blog

Welcome to the Blog App! This app allows users to create and browse blog posts with a simple and intuitive interface.

## Getting Started

### Tech Stack
**Frontend:**
- Flutter
- Dart

**Backend:**
- Supabase (for Authentication, Database, and Storage)

**Local Storage:**
- Hive

### Features
- **Post Blogs:** Users can easily create and publish blog content.
- **Image Upload:** Supports adding images to posts using Supabase Storage.
- **Authentication:** Secure email-based sign-in using Supabase.
- **Offline Support:**
  - Reads blog posts from Hive when the internet is unavailable.
  - Syncs blog data with Supabase when an internet connection is restored.
- **Responsive UI:** Ensures smooth experience on mobile and tablet devices.

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/atul-kumar-shahi/E-blog.git
   cd your-repo
   ```

2. **Install Dependencies**
   Run the following command to install the required dependencies:
   ```bash
   flutter pub get
   ```

3. **Environment Configuration**
   - Create a `.env` file in the root directory.
   - Add the following environment variables for Supabase:
     ```
     SUPABASE_URL=your_supabase_url
     SUPABASE_ANON_KEY=your_supabase_anon_key
     ```

4. **Run the Application**
   To launch the app, use:
   ```bash
   flutter run
   ```

## Challenges Faced
1. **Supabase Integration:** Encountered initial issues in setting up database tables and implementing secure email authentication.
2. **Hive Storage Setup:** Faced challenges in structuring data models and ensuring data persistence across app reloads.
3. **UI Complexity:** Implementing smooth UI transitions and dynamic content rendering posed a challenge.
4. **Offline Data Management:** Implemented logic to ensure data consistency between Hive (offline) and Supabase (online) without conflicts.
5. **Deployment Issues:** Managed to resolve Gradle version conflicts during the release build process.

## Future Improvements
- Implementing dark mode for enhanced user experience.
- Adding a feature for users to manage their published posts (edit and delete functionality).
- Enhancing performance by optimizing Supabase queries and Hive data handling.

## Contribution Guidelines
We welcome contributions to improve the Blog App!

### Steps to Contribute
1. Fork the repository.
2. Create a new branch: `git checkout -b feature/your-feature-name`.
3. Commit your changes: `git commit -m "Add your feature"`.
4. Push to your branch: `git push origin feature/your-feature-name`.
5. Open a pull request describing your changes.

## Learning Resources
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.

