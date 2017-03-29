# Our Family Recipes App

This app was developed as a class exersise for Udemy's The Complete Ruby on Rails Developer Course by Mashrur Hossain.  It was selected as the Student App of the Month.

## Features

- User authentications
- Image uploads to AWS
- Custom sorting
- Realtime chatting
- Bootstrap styling

### Data Structure

#### Chef
- chefname:string
- email:email
- admin:boolean

### Recipe
- name:string
- description:text
- steps:text
- recipeimage:text
- chef_id:integer

### Ingredient
- name:string

### recipe_ingredients
- recipe_id:integer
- ingredient_id:integer

### Comment
- description:text
- chef_id:integer
- recipe_id:integer

### Like
- like:boolean
- recipe_id:integer
- chef_id:integer

### Message
- content:text
- chef_id:integer