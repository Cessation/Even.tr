# ***even.tr***
Welcome to even.tr, events done right.

## User Stories & Project Description
#### Description
Even.tr is a platform for managing, tracking, and advertising events. It will allow organizations as well as individuals to create, view, and market events to all users of the platform. Even.tr will provide various data to event creaters and subscribers to provide a better picture of the content and audience at an event.

#### User Stories
- Login with Facebook
- Create event (location, time, title, hashtags, other metadata)
- View a timeline of upcoming events
    - Sort by different parameters (time, location, hashtags, topic, etc)
- View a particular event's details (location, time, title, hashtags, other metadata)
    - View attendees of event
- RSVP to events
- View RSVP'd events
- View location of events
- Modify event attributes
- Search events (by title, location, hashtags, etc)

#### Optional User Stories
- Scan event information from picture
- Export event to calendar (iOS or Google (or both))
- Comment on events
- Message event organizer
- Push notifications
- View est. number of attendees at event using GPS
- Optional default filters (by hashtag, etc.)

-----------------------------------
## Data Schema
The even.tr app will require only one table.
#### Events Table Attributes
- Name: Type (Purpose)
- Email: String (This will serve as an id indicating who created the event)
- Host: String (This will denote who is hosting the event)
- EventName: String (Denotes the event's name)
- Description: String (Denotes the event description)
- StartTime: String (Denotes the event start time)
- EndTime: String (Denotes the event end time (potentially optional))
- Location: String (Denotes location of event)
- Image: Image (Image uploaded and associated with event)
- Hashtags: Array (An array of hashtags associated with the event)
- RSVPCount: Integer (The # of persons that have committed to attending the event)
