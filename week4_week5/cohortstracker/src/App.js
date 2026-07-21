import React from "react";
import CohortDetails from "./CohortDetails";

function App() {
  // Sample cohorts matching the lab result design
  const cohorts = [
    {
      code: "INTADMDF10",
      name: ".NET FSD",
      startDate: "22-Feb-2022",
      status: "Scheduled",
      coach: "Aathma",
      trainer: "Jojo Jose",
    },
    {
      code: "ADM21JF014",
      name: "Java FSD",
      startDate: "10-Sep-2021",
      status: "Ongoing",
      coach: "Apoorv",
      trainer: "Elisa Smith",
    },
    {
      code: "CDBJF21025",
      name: "Java FSD",
      startDate: "24-Dec-2021",
      status: "Ongoing",
      coach: "Aathma",
      trainer: "John Doe",
    },
  ];

  return (
    <div style={{ padding: "20px", fontFamily: "sans-serif" }}>
      <h1>Cohorts Details</h1>
      <div>
        {cohorts.map((cohort, index) => (
          <CohortDetails key={index} cohort={cohort} />
        ))}
      </div>
    </div>
  );
}

export default App;
