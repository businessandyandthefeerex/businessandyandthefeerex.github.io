---
layout: page
title: Ashhurst, Ashhurst, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Ashhurst
city: Ashhurst
permalink: /country/new-zealand/manawatu/ashhurst/ashhurst/
---
[↑ Go to Ashhurst](/country/new-zealand/manawatu/ashhurst/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Ashhurst" | where: "city", "Ashhurst" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
  <h4>Rating: {{ group.name }}</h4>
  <ul>
    {% for post in group.items %}
      <li><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% endfor %}
