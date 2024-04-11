# Fahrplanauskunfts-App

Es soll ein Teil einer Fahrplanauskunfts-App erstellt werden, der dem Benutzer erlaubt, nach einem
Startpunkt zu suchen und sich mögliche Treffer anzeigen zu lassen.

## Getting Started

* We divided the App in small pieces where main lib contain only UI + state
 which we used riverpod to manage the State of the Application
* In the packages,we have 2 packages `search_repository`,`app_theme`
    * the `search_repository` package responsible to make the http request to provide the need it information and also we create our model and parser there.
    * the `app_theme` contain the theme of the application and some common part of the UI such as Button Styles


### Preview

<img src="https://github.com/liodali/Fahrplanauskunfts-App-/blob/main/ios_preview.gif?raw=true" alt="#Fahrplanauskunfts-App iOS"><br>


