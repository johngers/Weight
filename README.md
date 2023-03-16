Status: 

![CI](https://github.com/johngers/Weight/actions/workflows/CI.yml/badge.svg)

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

### Load Weight From Cache Use Case

#### Primary course:
1. Execute "Load Weight Item" command with above data.
2. System fetches weight data from cache.
3. System creates weight items from cached data.
4. System delivers weight items.

#### Error course (sad path):
1. System delivers error.

#### Empty cache course (sad path): 
1. System delivers no weight items.


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
