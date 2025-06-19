# Band Rehearsal Scheduler

A comprehensive web application designed to help bands and musical ensembles efficiently organize their rehearsal schedules, track attendance, send reminders, and suggest optimal rehearsal times based on member availability.

## Features

### For Band Leaders
- Create and manage band profiles
- Invite members via email with role assignments (admin, member, guest)
- Schedule one-time and recurring rehearsals
- View member availability and attendance
- Get AI-powered suggestions for optimal rehearsal times
- Track attendance history and statistics
- Attach materials and setlists to rehearsals

### For Band Members
- Join multiple bands
- Mark general availability patterns and specific date availability
- RSVP to rehearsal invitations
- Receive customizable reminders
- Access rehearsal materials and preparation notes
- View personal attendance history

## Technology Stack

### Frontend
- **Framework**: React.js
- **State Management**: Redux
- **UI Components**: Material-UI
- **Calendar Visualization**: FullCalendar.js
- **HTTP Client**: Axios
- **Form Validation**: Formik + Yup

### Backend
- **Runtime**: Node.js
- **Framework**: Express.js
- **Authentication**: JWT with Passport.js
- **API Documentation**: Swagger/OpenAPI

### Database
- **Primary Database**: PostgreSQL
- **Caching Layer**: Redis (optional, for performance)

### DevOps/Deployment
- **Containerization**: Docker
- **CI/CD**: GitHub Actions
- **Hosting**: AWS, Google Cloud, or Heroku
- **Email Service**: SendGrid or AWS SES

## Project Structure

```
├── client/                  # Frontend React application
│   ├── public/              # Static assets
│   ├── src/                 # Source code
│   │   ├── components/      # React components
│   │   ├── pages/           # Page components
│   │   ├── redux/           # Redux state management
│   │   ├── services/        # API service calls
│   │   ├── styles/          # CSS and style files
│   │   ├── utils/           # Utility functions
│   │   ├── App.js           # Main App component
│   │   └── index.js         # Entry point
│   └── package.json         # Frontend dependencies
│
├── server/                  # Backend Node.js/Express application
│   ├── config/              # Configuration files
│   ├── controllers/         # Route controllers
│   ├── middleware/          # Custom middleware
│   ├── models/              # Database models
│   ├── routes/              # API routes
│   ├── services/            # Business logic
│   ├── utils/               # Utility functions
│   ├── app.js               # Express app setup
│   └── server.js            # Server entry point
│
├── migrations/              # Database migrations
├── docker/                  # Docker configuration
├── .github/                 # GitHub Actions workflows
├── docker-compose.yml       # Docker Compose configuration
└── package.json             # Project dependencies and scripts
```

## Setup Instructions

### Prerequisites
- Node.js (v16+)
- npm or yarn
- PostgreSQL
- Redis (optional)
- Docker and Docker Compose (for containerized setup)

### Local Development Setup

1. **Clone the repository**
```bash
git clone https://github.com/dxaginfo/band-rehearsal-scheduler-app-2025.git
cd band-rehearsal-scheduler-app-2025
```

2. **Set up the backend**
```bash
# Navigate to the server directory
cd server

# Install dependencies
npm install

# Create a .env file (use .env.example as template)
cp .env.example .env

# Edit .env file with your configuration

# Run database migrations
npm run migrate

# Start the development server
npm run dev
```

3. **Set up the frontend**
```bash
# Navigate to the client directory
cd ../client

# Install dependencies
npm install

# Create a .env file (use .env.example as template)
cp .env.example .env

# Start the development server
npm start
```

4. **Access the application**
- Frontend: http://localhost:3000
- Backend API: http://localhost:8000
- API Documentation: http://localhost:8000/api-docs

### Docker Setup

1. **Clone the repository**
```bash
git clone https://github.com/dxaginfo/band-rehearsal-scheduler-app-2025.git
cd band-rehearsal-scheduler-app-2025
```

2. **Configure environment variables**
```bash
cp .env.example .env
# Edit .env file with your configuration
```

3. **Build and run with Docker Compose**
```bash
docker-compose up -d
```

4. **Access the application**
- Frontend: http://localhost:3000
- Backend API: http://localhost:8000
- API Documentation: http://localhost:8000/api-docs

## API Documentation

The API documentation is available at `/api-docs` when the server is running. It provides detailed information about all available endpoints, request/response formats, and authentication requirements.

## Database Schema

The application uses a relational database with the following main tables:
- Users
- Bands
- Band Memberships
- Rehearsals
- Availabilities
- Specific Date Availabilities
- Attendance
- Rehearsal Materials
- Notifications

For detailed schema information, see the [Database Schema Documentation](./docs/database-schema.md).

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

Project Link: [https://github.com/dxaginfo/band-rehearsal-scheduler-app-2025](https://github.com/dxaginfo/band-rehearsal-scheduler-app-2025)