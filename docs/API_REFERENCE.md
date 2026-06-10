# API Reference

## Cloud Functions

### Authentication Functions

#### `createUser()`
Creates a new user document when a new Firebase Auth user is registered.

**Trigger**: Firebase Auth user creation

**Request Body**:
```json
{
  "uid": "user-uid",
  "email": "user@example.com",
  "phoneNumber": "+1234567890",
  "displayName": "John Doe"
}
```

**Response**:
```json
{
  "success": true,
  "message": "User created successfully",
  "userId": "user-uid"
}
```

### Attendance Functions

#### `recordCheckIn()`
Records employee check-in with location and selfie.

**HTTP Method**: `POST`

**Endpoint**: `/recordCheckIn`

**Request Body**:
```json
{
  "userId": "user-uid",
  "timestamp": 1625097600000,
  "latitude": 28.6139,
  "longitude": 77.2090,
  "accuracy": 10.5,
  "address": "Delhi, India",
  "selfieUrl": "gs://bucket/selfies/..."
}
```

**Response**:
```json
{
  "success": true,
  "attendanceId": "attendance-id",
  "message": "Check-in recorded successfully",
  "timestamp": 1625097600000
}
```

#### `recordCheckOut()`
Records employee check-out.

**HTTP Method**: `POST`

**Endpoint**: `/recordCheckOut`

**Request Body**:
```json
{
  "userId": "user-uid",
  "timestamp": 1625118400000,
  "latitude": 28.6139,
  "longitude": 77.2090,
  "accuracy": 10.5,
  "address": "Delhi, India",
  "selfieUrl": "gs://bucket/selfies/..."
}
```

**Response**:
```json
{
  "success": true,
  "attendanceId": "attendance-id",
  "duration": 300,
  "message": "Check-out recorded successfully"
}
```

### Location Tracking Functions

#### `trackLocation()`
Records background location tracking data.

**HTTP Method**: `POST`

**Endpoint**: `/trackLocation`

**Request Body**:
```json
{
  "userId": "user-uid",
  "timestamp": 1625097600000,
  "latitude": 28.6139,
  "longitude": 77.2090,
  "accuracy": 10.5,
  "speed": 0,
  "bearing": 0,
  "address": "Delhi, India"
}
```

**Response**:
```json
{
  "success": true,
  "trackingId": "tracking-id",
  "message": "Location tracked successfully"
}
```

### Doctor Visit Functions

#### `submitDoctorVisitReport()`
Submits a doctor visit report.

**HTTP Method**: `POST`

**Endpoint**: `/submitDoctorVisitReport`

**Request Body**:
```json
{
  "userId": "user-uid",
  "date": "2021-07-01",
  "reason": "Regular checkup",
  "doctorName": "Dr. Smith",
  "clinicName": "City Clinic",
  "documentUrl": "gs://bucket/documents/...",
  "checkInTime": 1625097600000,
  "checkOutTime": 1625101200000
}
```

**Response**:
```json
{
  "success": true,
  "reportId": "report-id",
  "message": "Doctor visit report submitted successfully"
}
```

### Report Generation Functions

#### `generateAttendanceReport()`
Generates daily/weekly/monthly attendance reports.

**HTTP Method**: `POST`

**Endpoint**: `/generateAttendanceReport`

**Request Body**:
```json
{
  "startDate": "2021-07-01",
  "endDate": "2021-07-31",
  "reportType": "monthly",
  "format": "excel",
  "includeLocationData": true
}
```

**Response**:
```json
{
  "success": true,
  "reportUrl": "gs://bucket/reports/...",
  "generatedAt": 1625097600000,
  "fileName": "attendance-report-july-2021.xlsx"
}
```

#### `exportToExcel()`
Exports attendance data to Excel format.

**HTTP Method**: `POST`

**Endpoint**: `/exportToExcel`

**Request Body**:
```json
{
  "data": [...],
  "columns": ["name", "date", "checkIn", "checkOut", "duration"],
  "fileName": "attendance-export"
}
```

**Response**:
```json
{
  "success": true,
  "fileUrl": "gs://bucket/exports/...",
  "fileName": "attendance-export.xlsx"
}
```

### Notification Functions

#### `sendNotification()`
Sends push notification to user.

**HTTP Method**: `POST`

**Endpoint**: `/sendNotification`

**Request Body**:
```json
{
  "userId": "user-uid",
  "title": "Check-in Successful",
  "message": "Your check-in was recorded at 9:00 AM",
  "data": {
    "type": "attendance",
    "attendanceId": "attendance-id"
  }
}
```

**Response**:
```json
{
  "success": true,
  "notificationId": "notification-id"
}
```

## Error Responses

All endpoints return error responses in the following format:

```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable error message"
  }
}
```

### Common Error Codes

- `INVALID_INPUT` - Request body validation failed
- `UNAUTHORIZED` - User is not authenticated
- `PERMISSION_DENIED` - User doesn't have permission
- `NOT_FOUND` - Resource not found
- `INTERNAL_ERROR` - Server error
- `GPS_INVALID` - GPS coordinates invalid or spoofed
