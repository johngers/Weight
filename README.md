Status: 

![CI](https://github.com/johngers/Weight/actions/workflows/CI.yml/badge.svg)

## Things to do:

### ✅ Individualize storing of weights. Right now storing a weight is related to an entire log. This makes accessing individual items harder in the current design and is important for what we want to do with the data. Doing this will allow us to input single items, delete single items, merge items by day, and fetch groups of items for related charts much easier.
### ✅ Create an input view for inputting weights.
### Go through WeightItem related tests and clean up references to "log" and ensure the behavior is correct.

## Things left to add MVP

### Input for weight and calories (weight will be one a day, calories can add up on the same day)
### Setting a goal for all three categories
### Sync weight and steps with Apple Health
### Display data in detail with charts
### Haptics on buttons
### Notifications
### Live Activities
### Select starting tab and available tabs
### Theme customization for all three categories.
### App Icon change
### About (featuring social links, tipping, rating app, and current app version)
### Delete app data button
### Animations for progress bars, drawing charts, and tab page indicators
### Triple ring overview

## Things left to add non-MVP

### Watch app
### Mac app 
### TV app 
### iPad Layout

## Ideas 

### AR mode for steps that shows a line for remaining steps
### Camera mode for reading digital scale numbers to input

## BDD Specs

### Story: Customer requests to see their weight log feed

```

### Narrative #1

```
As an offline customer
I want the app to show the latest saved version of my weight log feed
So I can always track my progress
```

#### Scenarios (Acceptance criteria)

```
Given the customer doesn't have connectivity
  And there’s a cached version of the weight log
 When the customer requests to see the weight
 Then the app should display the latest weight log saved
```

## Use Cases

### Load Weight Log From Cache Use Case

#### Primary course:
1. Execute "Load Weight Log" command with above data.
2. System fetches weight log data from cache.
3. System creates weight log from cached data.
4. System delivers weight log.

#### Error course (sad path):
1. System delivers error.

#### Empty cache course (sad path): 
1. System delivers no weight log.


### Cache Weight Use Case

#### Data:
- Weight items

#### Primary course (happy path):
1. Execute "Save Weight Item" command with above data.
2. System encodes weight items.
3. System saves new cache data.
4. System delivers success message.

#### Deleting error course (sad path):
1. System delivers error.

#### Saving error course (sad path):
1. System delivers error.

## Model Specs

### Weight Item

| Property      | Type                |
|---------------|---------------------|
| `id`          | `UUID`              |
| `weight`      | `Double`            |
| `date`        | `Date`              |

- Retrieve
    ✅ Empty cache
    ✅ Empty cache twice returns empty (no side-effects)
    ✅ Non-empty cache returns data
    ✅ Non-empty cache twice returns same data (no side-effects)
    ✅ Error returns error (if applicable, e.g., invalid data)
    ✅ Error twice returns same error (if applicable, e.g., invalid data)

- Insert
    ✅ To empty cache stores data
    ✅ To non-empty cache prepends new data to previous data
    ✅ Error (if applicable, e.g., no write permission)

- Delete
    ✅ Empty cache does nothing (cache stays empty and does no fail)
    ✅ Non-empty cache leaves cache empty
    ✅ Error (if applicable, e.g., no delete permission)
    
- Side-effects must run serially to avoid race-conditions

Story: Customer requests to see their image feed
Narrative #1
As an online customer 

I want the app to automatically load my latest image feed 

So I can always enjoy the newest images of my friends

Scenarios (Acceptance criteria)
Given the customer has connectivity 

When the customer requests to see the feed

Then the app should display the latest feed from remote

And replace the cache with the new feed

Narrative #2
As an offline customer

I want the app to show the latest saved version of my image feed

So I can always enjoy images of my friends

Scenarios (Acceptance criteria)
Given the customer doesn't have connectivity

And there’s a cached version of the feed

When the customer requests to see the feed

Then the app should display the latest feed saved



Given the customer doesn't have connectivity

And the cache is empty

When the customer requests to see the feed

Then the app should display an error message



Load Feed Use Case
Data (Input):
URL
Primary course (happy path):
Execute "Load Feed Items" command with above data.
System downloads data from the URL.
System validates downloaded data.
System creates feed items from valid data.
System delivers feed items.
Invalid data – error course (sad path):
System delivers error.
No connectivity – error course (sad path):
System delivers error.
Load Feed Fallback (Cache) Use Case
Data (Input):
Max age
Primary course (happy path):
Execute "Retrieve Feed Items" command with above data.
System fetches feed data from cache.
System creates feed items from cached data.
System delivers feed items.
No cache course (sad path):
System delivers no feed items.
Save Feed Items Use Case
Data (Input):
Feed items
Primary course (happy path):
Execute "Save Feed Items" command with above data.
System encodes feed items.
System timestamps the new cache.
System replaces the cache with new data.
System delivers a success message.
