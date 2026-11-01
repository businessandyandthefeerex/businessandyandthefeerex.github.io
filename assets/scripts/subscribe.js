document.addEventListener("DOMContentLoaded", function () {
  const form = document.forms["mailing-list"];
  if (!form) return;

  form.addEventListener("submit", async function (event) {
    event.preventDefault(); // Stop the default submission

    const email = form.email.value;

    // Send email address to Pipedream
    try {
      const response = await fetch("https://eoinsrvi7apkqha.m.pipedream.net", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email: email }),
      });
      if (!response.ok) throw new Error("HTTP " + response.status);

      // Redirect after successful submission
      window.location.href = "/thanks/";
    } catch (error) {
      console.error("Webhook failed", error);
      alert("Something went wrong. Please try again.");
    }
  });
});
