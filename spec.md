# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project - using Rails
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes) - User has_many Volunteers
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User) - Activity belongs_to Volunteer
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients) - Volunteer has_many roles through activities, Role has_many volunteers through activities
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients) - Volunteer has_many roles through activities, Role has_many volunteers through activities 
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity) - Activity has a duration and date
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item) - Validations for presence of key attributes for each model, uniqueness of user email address, etc.
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes) - Activity.newest URL: /activities?query=newest
- [x] Include signup (how e.g. Devise) - sign up route, users#new action, users/new.html.erb form
- [x] Include login (how e.g. Devise) - login route, sessions#new action, sessions/new.html.erb form
- [x] Include logout (how e.g. Devise) - logout post route, sessions#destroy action, link in nav bar that uses delete method 
- [x] Include third party signup/login (how e.g. Devise/OmniAuth) - set up OmniAuth signin via GitHub
- [x] Include nested resource show or index (URL e.g. users/2/recipes) - volunteers/:volunteer_id/activities
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new) - volunteers/:volunteer_id/activities/new
- [x] Include form display of validation errors (form URL e.g. /recipes/new) - partial for displaying validation errors is used in all form-related views

Confirm:
- [x] The application is pretty DRY - used partials, helpers and before_action/skip_before_action macros to reduce repetition 
- [x] Limited logic in controllers - handled main queries in the models to keep this logic out of the controllers
- [x] Views use helper methods if appropriate - used helpers to encapsulate repeated tasks and reduce logic in views
- [x] Views use partials if appropriate - used partials with locals for displaying forms and validation errors