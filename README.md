# iaidō Assignment - Basic Banking App

A very basic banking app built in Flutter.

<image src="https://github.com/andre-tm-hui/iaido-assessment/assets/34312863/0fa2bec2-9d91-4b56-93cf-6c20481b166d" style="width: 24%"/>

<image src="https://github.com/andre-tm-hui/iaido-assessment/assets/34312863/2dfc8980-a164-4f35-a570-38b727ff2e11" style="width: 24%"/>

<image src="https://github.com/andre-tm-hui/iaido-assessment/assets/34312863/68d1b636-ba7b-4aa5-a6b9-0c3fbcb4e311" style="width: 24%"/>

<image src="https://github.com/andre-tm-hui/iaido-assessment/assets/34312863/7f534108-2181-4046-ad99-7edb0060911c" style="width: 24%"/>

## Primary Requirements

- GetX for state management and page routing

- iOS/Android compatible using cross-platform capabilities of Flutter

- Usable and nice web version

### Other Features

- Top up your wallet

- Make payments with named payees

- View an automatically updating list of transactions, separated by transaction date

- Robust amount formatter for inputting monetary values

- Persistent transactions storage (only on mobile)

- Validation on amount form to prevent spending more than the balance

- sqlite database using [drift](https://pub.dev/packages/drift)

## Setup Guide

### Prerequisites

- Flutter 3.19.3

- Dart 3.3.1

- sqlite3 (\*optional [for testing](https://drift.simonbinder.eu/docs/testing/#setup))

### Instructions

1. Clone the repository and run `flutter pub get`.

2. Run `dart run build_runner build --delete-conflicting-outputs` to generate files for the drift DB.

3. Build and deploy as normal. (You may have to run `flutter create --platforms web/ios/android` before building for the respective platforms)

#### Testing

To run the tests, run `flutter test`.

Since we're using drift, testing the database requires a sqlite3 installation. Follow the above for more instructions. These tests are skipped by default, but if you have sqlite3 installed/in your path, you can run them using `flutter test --run-skipped`.

## Notes

### Architecture

For the scale of this project, I decided to use a layer-first project structure. The scale of the app is small enough that this doesn't hurt file navigation, and for this project specifically, features overlap (e.g. the home page utilizes both transactions and balance), making it harder to organise in a feature-first structure.

I used the standard Presentation -> Application -> Domain -> Data/Infrastructure layers for this project. Truthfully, the domain layer might not even be necessary, given that the drift library creates the transaction structure for us, and the balance is a simple double. However, it's always nice to have for scalability in the future.

### Data

To store transactions, I chose drift because a structured database seemed most suitable for the type of data being managed, as opposed to unstructured K-V databases. This also allowed me to save time from building things like DTOs and various other data handlers.

As for the balance value, it was simple enough to build a Source object that saves the value to a locally stored file. Automatic saving on balance updates was implemented using get/setters.

In both cases, web clients don't allow access to local storage, so I opted to omit this feature. In reality, such data would be stored in the cloud using hosts such as GCP/Firebase.

### Web

To adapt the web version, I didn't want to conditionally reimplement widgets/layouts, so I simply imposed some constraints to limit their width on wide screens. This has the added benefit of also looking better for tablets.

### UX

#### Animations?

Since everything is local, data access times are often too quick for fancy loading screens to make sense, and I didn't want to artificially increase page-load times, since that's more important to UX.

#### Aesthetics

To keep a consistent aesthetic/theme, I've implemented a custom ThemeData object, as well as declared a few const colours for a colour scheme. This makes it easy modify the look and feel of the app, at least in terms of colour. I've also opted against making a full page with a brightly coloured background, as was shown in the original assessment examples, to make the app easier to look at.

For usability, keeping widgets simple and minimal was the target.

#### Other

One thing inspired by the original assessment examples is an expanding text field (non-standard in Flutter). Purely just because I like how it interacts and keeps everything centered, I made a TextField that shrinks and expands with the size of the text. This way, the '£' is always directly left of the amount value.
