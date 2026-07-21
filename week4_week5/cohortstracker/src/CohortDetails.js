import React from "react";
import styles from "./CohortDetails.module.css"; // Import CSS module

function CohortDetails({ cohort }) {
  // Title style: Green if status is "Ongoing", Blue otherwise
  const titleStyle = {
    color: cohort.status.toLowerCase() === "ongoing" ? "green" : "blue",
  };

  return (
    <div className={styles.box}>
      <h3 style={titleStyle}>
        {cohort.code} - {cohort.name}
      </h3>
      <dl>
        <dt>Started On</dt>
        <dd>{cohort.startDate}</dd>
        <dt>Current Status</dt>
        <dd>{cohort.status}</dd>
        <dt>Coach</dt>
        <dd>{cohort.coach}</dd>
        <dt>Trainer</dt>
        <dd>{cohort.trainer}</dd>
      </dl>
    </div>
  );
}

export default CohortDetails;
