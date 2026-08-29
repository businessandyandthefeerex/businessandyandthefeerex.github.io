---
layout: page
title: 84 Fitzherbert Avenue, 84 Fitzherbert Avenue, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: 84 Fitzherbert Avenue
city: 84 Fitzherbert Avenue
permalink: /country/new-zealand/manawatu/84-fitzherbert-avenue/84-fitzherbert-avenue/
---
[↑ Go to 84 Fitzherbert Avenue](/country/new-zealand/manawatu/84-fitzherbert-avenue/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "84 Fitzherbert Avenue" | where: "city", "84 Fitzherbert Avenue" %}
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
