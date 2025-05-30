# **RecipeFetch App**

##  **Summary**

- This SwiftUI app shows a list of recipes from an online source.
Main features include:

- Displays each recipe’s name, cuisine type, and image.

- Users can refresh the list by pulling down.

- Tapping a recipe shows more details:

- Full-size image (if available).

- Clickable links to the recipe website and YouTube (if available).

- Handles empty or bad data by showing a clear message.

- Saves images to disk to avoid downloading them again.

- Built with SwiftUI for a modern and clean design.

- Users can sort recipes by name or cuisine.

##  **Demo**

![Simulator Screenshot - iPhone 16 - 2025-05-30 at 00 47 19](https://github.com/user-attachments/assets/1ee6f3fa-25d1-40fc-a163-1dc42eed6aa1) 

![Simulator Screen Recording - iPhone 16 - 2025-05-30 at 00 16 24](https://github.com/user-attachments/assets/805e8dd2-b983-40f1-988e-7007098b3cf9)

##  **Focus Areas**
- Used async/await to handle network calls and image loading.

- Created a custom image cache using FileManager to meet the “no external libraries” requirement.

- Focused on a simple and user-friendly interface.

- Added a detailed view with clickable source and YouTube links.

- Wrote tests using a mock cache to ensure tests work without internet.

##  **Time Spent**
Total: 5 hours

- 1.5 hours: Setting up data models, networking, and error handling.

- 2.5 hours: Building the list and detailed views with SwiftUI.

- 1 hour: Writing tests and README, replacing real network calls with a mock cache.

##  **Decisions**
- Used a simple disk-based image cache instead of third-party libraries.

- Added an detailed view for each recipe to improve experience.

- Included an option to sort recipes by name or cuisine.

- Focused on the most important features by adding extra filters or search options.

- Did not add a system to clear old images from cache due to time limits.

## **Things to Improve**
- The image cache works but could be improved to clear old or unused images.

- The UI could include features like filtering or search for a richer experience.

## **Additional Information**
- Supports iOS 16 and up.

- Used only Apple frameworks, with no extra libraries.

- Tests use a mock cache, so they work even without internet.

- The app is organized and tested as if it were part of a real project.
