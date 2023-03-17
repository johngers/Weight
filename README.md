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
    - Non-empty cache returns data
    - Non-empty cache twice returns same data (no side-effects)
    - Error returns error (if applicable, e.g., invalid data)
    - Error twice returns same error (if applicable, e.g., invalid data)

- Insert
    - To empty cache stores data
    - To non-empty cache appends new data to previous data
    - Error (if applicable, e.g., no write permission)

- Delete
    - Empty cache does nothing (cache stays empty and does no fail)
    - Non-empty cache leaves cache empty
    - Error (if applicable, e.g., no delete permission)
    
- Side-effects must run serially to avoid race-conditions
