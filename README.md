## How the app works (models → services → screens)

I separated the app into models, services, and screens so each part has a clear job. The models describe the data used by the app. For example, `Post` and `Comment` contain the fields returned by DummyJSON and include `fromJson()` methods to convert JSON into Dart objects. `UserModel` stores the logged-in user information.

The services are responsible for communicating with DummyJSON. `AuthService` logs in the user and saves the session details with `shared_preferences`. `PostService` loads the newsfeed and profile posts, while `CommentService` loads comments for a selected post. The services return model objects instead of raw JSON, which keeps the UI easier to read.

The screens call the services and display the results. `SplashScreen` checks if a saved session exists, `SignInScreen` starts authentication, `NewsfeedScreen` displays the posts, `ProfileScreen` requests posts using the saved user ID, and `DetailScreen` displays one post and its comments. Widgets such as `PostCard` handle reusable UI actions like liking and opening the detail screen. This flow makes the app easier to update because API code stays in services and display code stays in screens.

DummyJSON is a testing API, so fetched data is real during the session, but simulated likes and newly added comments are not permanently saved on the server.