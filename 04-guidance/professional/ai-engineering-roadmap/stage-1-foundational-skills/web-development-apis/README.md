# 1.4 Web Development & APIs

Learn HTTP, REST APIs, and building web applications.

**← Back to**: [Stage 1: Foundational Skills](../README.md)

---

## 📚 What You'll Learn

- **HTTP and REST Basics**: HTTP fundamentals, REST API principles, JSON format
- **Making HTTP Requests in Python**: Basic requests, error handling, authentication, advanced requests
- **FastAPI Fundamentals**: FastAPI basics, request handling, response handling, Pydantic models
- **Advanced API Concepts**: Error handling, authentication & authorization, CORS, middleware, database integration

---

## 🔗 Learning Resources

### Related Areas
- [1.3 Data & Databases](../data-databases/README.md)
- [1.5 Command Line & DevOps Basics](../command-line-devops/README.md)
- [Stage 1 Overview](../README.md)

---

## HTTP and REST Basics

Understanding the web is essential for AI engineers.

### HTTP Fundamentals

- [ ] **Understand HTTP methods** (GET, POST, PUT, DELETE)
- [ ] **Understand status codes** (200, 404, 500, etc.)
- [ ] **Know common headers** (Content-Type, Authorization)
- [ ] **Understand request/response cycle**
- [ ] **Know difference between sync and async** calls

**Practice:** Make HTTP calls using browser dev tools

### REST API Principles

- [ ] **Understand REST constraints**
- [ ] **Design RESTful endpoints** (nouns for resources)
- [ ] **Use HTTP methods correctly** (GET for read, POST for create)
- [ ] **Version APIs** properly
- [ ] **Document API contracts**

**Practice:** Design API for 3 different domains

### JSON Format

- [ ] **Understand JSON structure** (objects, arrays)
- [ ] **Parse JSON** in Python
- [ ] **Generate JSON** from Python objects
- [ ] **Validate JSON** schemas
- [ ] **Handle JSON edge cases** (nulls, types)

**Practice:** Parse/generate JSON files

---

## Making HTTP Requests in Python

The `requests` library is your best friend.

### Basic Requests

- [ ] **Make GET requests**
- [ ] **Make POST requests**
- [ ] **Make PUT/DELETE requests**
- [ ] **Add headers** to requests
- [ ] **Parse response** JSON

**Practice:** Call 5+ public APIs

### Error Handling

- [ ] **Handle HTTP errors** (404, 500, etc.)
- [ ] **Use try/except** for network errors
- [ ] **Retry failed requests** with exponential backoff
- [ ] **Timeout requests** to prevent hanging
- [ ] **Log errors** for debugging

**Practice:** Handle errors from 3+ APIs

### Authentication

- [ ] **API key authentication**
- [ ] **Bearer token authentication**
- [ ] **Basic authentication** (username/password)
- [ ] **OAuth 2.0** basics
- [ ] **Store secrets** safely (not in code)

**Practice:** Authenticate with 2+ APIs

### Advanced Requests

- [ ] **Use sessions** for connection pooling
- [ ] **Stream large responses**
- [ ] **Upload files** (multipart/form-data)
- [ ] **Handle redirects**
- [ ] **Rate limiting** awareness

**Practice:** Build robust HTTP client

---

## FastAPI Fundamentals

Building modern APIs is surprisingly easy.

### FastAPI Basics

- [ ] **Create FastAPI application**
- [ ] **Define endpoints** (routes)
- [ ] **Return JSON responses**
- [ ] **Accept parameters** (path, query, body)
- [ ] **Use type hints** (Pydantic models)

**Practice:** Create 5-endpoint API

### Request Handling

- [ ] **Path parameters** (`/users/{user_id}`)
- [ ] **Query parameters** (`?skip=0&limit=10`)
- [ ] **Request body** (POST data)
- [ ] **Form data** submission
- [ ] **File uploads** handling

**Practice:** Accept multiple parameter types

### Response Handling

- [ ] **Return JSON** responses
- [ ] **Set status codes** properly
- [ ] **Return different types** (objects, lists, strings)
- [ ] **Include headers** in response
- [ ] **Handle exceptions** with error responses

**Practice:** Return various response types

### Pydantic Models

- [ ] **Define data models** as classes
- [ ] **Use type hints** in models
- [ ] **Validate input** with Pydantic
- [ ] **Handle optional fields**
- [ ] **Understand model serialization**

**Practice:** Create 10+ data models

---

## Advanced API Concepts

Building production APIs requires more knowledge.

### Error Handling

- [ ] **Return proper HTTP status codes** for errors
- [ ] **Create error response format**
- [ ] **Log errors** for debugging
- [ ] **Handle validation errors**
- [ ] **Send helpful error messages**

**Practice:** Implement comprehensive error handling

### Authentication & Authorization

- [ ] **Implement JWT authentication**
- [ ] **Create login endpoint**
- [ ] **Protect endpoints** with authentication
- [ ] **Use roles/permissions** for authorization
- [ ] **Refresh tokens** lifecycle

**Practice:** Build secure authentication system

### CORS

- [ ] **Understand CORS** (cross-origin requests)
- [ ] **Enable CORS** in FastAPI
- [ ] **Configure allowed origins**
- [ ] **Understand preflight requests**
- [ ] **Handle CORS errors** in frontend

**Practice:** Set up CORS for frontend integration

### Middleware

- [ ] **Understand middleware** pattern
- [ ] **Add logging middleware**
- [ ] **Add authentication middleware**
- [ ] **Add error handling middleware**
- [ ] **Order middleware correctly**

**Practice:** Create 3+ custom middleware

### Database Integration

- [ ] **Connect FastAPI to database**
- [ ] **Use SQLAlchemy with FastAPI**
- [ ] **Implement CRUD endpoints**
- [ ] **Use dependency injection**
- [ ] **Manage database sessions**

**Practice:** Build full CRUD API with database

---

## ✅ Learning Checklist

- [ ] Understand HTTP and REST
- [ ] Make API requests with requests library
- [ ] Build FastAPI application
- [ ] Handle errors properly
- [ ] Implement authentication
- [ ] Integrate with database

---

*Last updated: 2025-11-03*
