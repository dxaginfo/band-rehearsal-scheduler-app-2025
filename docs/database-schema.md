# Database Schema Documentation

## Overview

This document provides detailed information about the database schema used in the Band Rehearsal Scheduler application.

## Tables

### Users Table
```
users
- id (PK)
- email
- password_hash
- first_name
- last_name
- phone_number (optional)
- created_at
- updated_at
```

### Bands Table
```
bands
- id (PK)
- name
- description
- created_by (FK -> users.id)
- created_at
- updated_at
```

### Band Memberships Table
```
band_memberships
- id (PK)
- band_id (FK -> bands.id)
- user_id (FK -> users.id)
- role (enum: 'admin', 'member', 'guest')
- joined_at
```

### Rehearsals Table
```
rehearsals
- id (PK)
- band_id (FK -> bands.id)
- title
- description
- location
- start_time
- end_time
- is_recurring
- recurrence_pattern (JSON, if recurring)
- created_by (FK -> users.id)
- created_at
- updated_at
```

### Availabilities Table
```
availabilities
- id (PK)
- user_id (FK -> users.id)
- day_of_week (for recurring)
- start_time
- end_time
- is_all_day
- created_at
- updated_at
```

### Specific Date Availabilities Table
```
specific_availabilities
- id (PK)
- user_id (FK -> users.id)
- date
- is_available (boolean)
- created_at
- updated_at
```

### Attendance Table
```
attendance
- id (PK)
- rehearsal_id (FK -> rehearsals.id)
- user_id (FK -> users.id)
- status (enum: 'attending', 'not_attending', 'maybe', 'no_response')
- created_at
- updated_at
```

### Rehearsal Materials Table
```
rehearsal_materials
- id (PK)
- rehearsal_id (FK -> rehearsals.id)
- title
- description
- file_url (optional)
- created_by (FK -> users.id)
- created_at
- updated_at
```

### Notifications Table
```
notifications
- id (PK)
- user_id (FK -> users.id)
- type (enum: 'rehearsal_reminder', 'new_rehearsal', 'cancelled_rehearsal', etc.)
- content
- is_read
- related_id (polymorphic reference)
- created_at
```

## Relationships

1. **Users to Bands** (Many-to-Many through Band Memberships)
   - A user can be a member of multiple bands
   - A band can have multiple users as members

2. **Bands to Rehearsals** (One-to-Many)
   - A band can have multiple rehearsals
   - A rehearsal belongs to one band

3. **Users to Availabilities** (One-to-Many)
   - A user can have multiple availability records
   - An availability record belongs to one user

4. **Users to Specific Date Availabilities** (One-to-Many)
   - A user can have multiple specific date availability records
   - A specific date availability record belongs to one user

5. **Rehearsals to Attendance** (One-to-Many)
   - A rehearsal can have multiple attendance records
   - An attendance record belongs to one rehearsal

6. **Users to Attendance** (One-to-Many)
   - A user can have multiple attendance records
   - An attendance record belongs to one user

7. **Rehearsals to Rehearsal Materials** (One-to-Many)
   - A rehearsal can have multiple material records
   - A material record belongs to one rehearsal

8. **Users to Notifications** (One-to-Many)
   - A user can have multiple notifications
   - A notification belongs to one user
