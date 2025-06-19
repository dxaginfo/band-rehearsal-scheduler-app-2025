-- Users Table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  phone_number VARCHAR(20),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Bands Table
CREATE TABLE bands (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  created_by INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Band Memberships Table
CREATE TABLE band_memberships (
  id SERIAL PRIMARY KEY,
  band_id INTEGER NOT NULL REFERENCES bands(id) ON DELETE CASCADE,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role VARCHAR(20) NOT NULL CHECK (role IN ('admin', 'member', 'guest')),
  joined_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(band_id, user_id)
);

-- Rehearsals Table
CREATE TABLE rehearsals (
  id SERIAL PRIMARY KEY,
  band_id INTEGER NOT NULL REFERENCES bands(id) ON DELETE CASCADE,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  location VARCHAR(255),
  start_time TIMESTAMP NOT NULL,
  end_time TIMESTAMP NOT NULL,
  is_recurring BOOLEAN NOT NULL DEFAULT FALSE,
  recurrence_pattern JSONB,
  created_by INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CHECK (end_time > start_time)
);

-- Availabilities Table (recurring)
CREATE TABLE availabilities (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  day_of_week INTEGER NOT NULL CHECK (day_of_week BETWEEN 0 AND 6),
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  is_all_day BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CHECK (end_time > start_time OR is_all_day = TRUE)
);

-- Specific Date Availabilities Table
CREATE TABLE specific_availabilities (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  is_available BOOLEAN NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(user_id, date)
);

-- Attendance Table
CREATE TABLE attendance (
  id SERIAL PRIMARY KEY,
  rehearsal_id INTEGER NOT NULL REFERENCES rehearsals(id) ON DELETE CASCADE,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  status VARCHAR(20) NOT NULL CHECK (status IN ('attending', 'not_attending', 'maybe', 'no_response')),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(rehearsal_id, user_id)
);

-- Rehearsal Materials Table
CREATE TABLE rehearsal_materials (
  id SERIAL PRIMARY KEY,
  rehearsal_id INTEGER NOT NULL REFERENCES rehearsals(id) ON DELETE CASCADE,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  file_url VARCHAR(255),
  created_by INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Notifications Table
CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type VARCHAR(50) NOT NULL,
  content TEXT NOT NULL,
  is_read BOOLEAN NOT NULL DEFAULT FALSE,
  related_id INTEGER,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for improved query performance
CREATE INDEX idx_band_memberships_band_id ON band_memberships(band_id);
CREATE INDEX idx_band_memberships_user_id ON band_memberships(user_id);
CREATE INDEX idx_rehearsals_band_id ON rehearsals(band_id);
CREATE INDEX idx_rehearsals_start_time ON rehearsals(start_time);
CREATE INDEX idx_availabilities_user_id ON availabilities(user_id);
CREATE INDEX idx_specific_availabilities_user_id ON specific_availabilities(user_id);
CREATE INDEX idx_specific_availabilities_date ON specific_availabilities(date);
CREATE INDEX idx_attendance_rehearsal_id ON attendance(rehearsal_id);
CREATE INDEX idx_attendance_user_id ON attendance(user_id);
CREATE INDEX idx_notifications_user_id ON notifications(user_id);

-- Create trigger functions for updating timestamps
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for all tables with timestamps
CREATE TRIGGER update_users_timestamp
BEFORE UPDATE ON users
FOR EACH ROW EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_bands_timestamp
BEFORE UPDATE ON bands
FOR EACH ROW EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_rehearsals_timestamp
BEFORE UPDATE ON rehearsals
FOR EACH ROW EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_availabilities_timestamp
BEFORE UPDATE ON availabilities
FOR EACH ROW EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_specific_availabilities_timestamp
BEFORE UPDATE ON specific_availabilities
FOR EACH ROW EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_attendance_timestamp
BEFORE UPDATE ON attendance
FOR EACH ROW EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER update_rehearsal_materials_timestamp
BEFORE UPDATE ON rehearsal_materials
FOR EACH ROW EXECUTE FUNCTION update_timestamp();
