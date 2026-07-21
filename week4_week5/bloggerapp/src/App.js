import React from "react";

// Export books array with id, bname, and price
export const books = [
  { id: 101, bname: "Master React", price: 670 },
  { id: 102, bname: "Deep Dive into Angular 11 ", price: 800 },
  { id: 103, bname: "Mongo Essentials", price: 450 },
];

// Book Details Component (uses map with key as required)
function BookDetails() {
  return (
    <ul>
      {books.map((book) => (
        <div key={book.id}>
          <h3>{book.bname}</h3>
          <h4>{book.price}</h4>
        </div>
      ))}
    </ul>
  );
}

// Blog Details Component
function BlogDetails() {
  return (
    <div>
      <h3>React Learning</h3>
      <p>
        <b>Stephen Biz</b>
      </p>
      <p>Welcome to learning React!</p>
      <h3>Installation</h3>
      <p>
        <b>Schewzdenier</b>
      </p>
      <p>You can install React from npm.</p>
    </div>
  );
}

// Course Details Component
function CourseDetails() {
  return (
    <div>
      <h3>Angular</h3>
      <p>4/5/2021</p>
      <h3>React</h3>
      <p>6/3/2020</p>
    </div>
  );
}

// Main App Component rendering all three side-by-side
function App() {
  return (
    <div
      style={{
        display: "flex",
        justifyContent: "space-around",
        padding: "20px",
        fontFamily: "sans-serif",
      }}
    >
      <div>
        <h1>Course Details</h1>
        <CourseDetails />
      </div>
      <div style={{ borderLeft: "3px solid green", paddingLeft: "30px" }}>
        <h1>Book Details</h1>
        <BookDetails />
      </div>
      <div style={{ borderLeft: "3px solid green", paddingLeft: "30px" }}>
        <h1>Blog Details</h1>
        <BlogDetails />
      </div>
    </div>
  );
}

export default App;
