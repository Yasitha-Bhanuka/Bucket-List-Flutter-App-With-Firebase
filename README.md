## Project Overview

This Flutter project serves as a starting point for building Flutter applications. It includes various features and functionalities that can be used as a reference or a template for your own projects.

## Tools and Technologies Used

- Flutter: Flutter is an open-source UI software development kit created by Google. It allows you to build natively compiled applications for mobile, web, and desktop from a single codebase.

- Firebase: Firebase is a mobile and web application development platform that provides various services and tools for building high-quality apps. In this project, Firebase is used for data storage and retrieval.

- Dio: Dio is a powerful HTTP client for Dart, which is used for making API requests and handling responses in this project.

## Key Features

- Form Validation: The project implements form validation using the `Form` widget and `TextFormField` to ensure that the input field is not empty. ✅

- Adding New Items: The functionality to add new bucket list items is enabled, allowing users to easily add new items to their list. ➕

- Marking Items as Done: Users can mark items as done using a PATCH request API. The project includes a `markAsDone` function and implements conditional rendering to display only incomplete items. ✅

- Handling No Changes: The project handles the scenario where the user does not make any changes to an item and goes back to the bucket list screen. It triggers a refresh of the bucket list screen. ♻️

- Deleting Items: The project activates the delete API by passing the index as a parameter to delete a specific item. ❌

- Conditional Rendering: The project implements conditional rendering to render the list as invisible if the list item is null. It also displays a "No data in bucket list" message if the item list is empty. ❌

- Image Display: After clicking on a list item, the project displays the image using the `Container` widget and `NetworkImage`. 🖼️

- Navigation: The project implements navigation between screens using `MaterialPageRoute` and named routes. 🚀

- Loading Indicator: The project uses conditional rendering to display a `CircularProgressIndicator` while loading data. ⏳

- Auto-Refreshing: The project includes a `RefresherIndicator` widget for auto-refreshing the page. ♻️

- Data Fetching: The project fetches data from Firebase using the `getData` async function and displays it in the main screen using `Column`, `Expanded`, and `ListView.builder`. 🔄

- Error Handling: The project implements error handling using a try-catch block while fetching data from the API. ❌

### See The Snap Shot In This Work

## App Icon

<img src="assets/screenshots/AppIcon.png" alt="App Icon" width="200"/>

## App Welcome Screen

<img src="assets/screenshots/Welcome.png" alt="Welcome Screen" width="200"/>

## Bucket List 

<img src="assets/screenshots/List.png" alt="Bucket List" width="200"/>

## Item View

<img src="assets/screenshots/PictureView.png" alt="Item View" width="200"/>

## Item Manage

<img src="assets/screenshots/Delete.png" alt="Item Manage" width="200"/>

## Item Delete Alert

<img src="assets/screenshots/deletealert.png" alt="Item Delete Alert" width="200"/>

## Item After Deleting

<img src="assets/screenshots/afterdelete.png" alt="Item After Deleting" width="200"/>

## Item Adding

<img src="assets/screenshots/addingnewlist.png" alt="Item Adding" width="200"/>

## Item Adding From Validation

<img src="assets/screenshots/Validation.png" alt="Item Adding From Validation" width="200"/>

## Input Details Correctly

<img src="assets/screenshots/inputdetailscorrect.png" alt="Input Details Correctly" width="200"/>

## After Added Item

<img src="assets/screenshots/afteradding.png" alt="After Added Item" width="200"/>

## When Reloading App Is On Operational Task

<img src="assets/screenshots/whenrefreshing.png" alt="When Reloading App Is On Operational Task" width="200"/>

## When Bucket List Is Empty

<img src="assets/screenshots/BucketEmpty.png" alt="When Bucket List Is Empty" width="200"/>


## Conclusion

This project demonstrates the use of Flutter, Firebase, and Dio to build a Flutter application with various features and functionalities. It provides a solid foundation for building your own Flutter projects. Feel free to explore the code and use it as a reference for your own projects.