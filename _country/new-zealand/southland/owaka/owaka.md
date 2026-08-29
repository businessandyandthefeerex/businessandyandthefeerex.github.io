---
layout: page
title: Owaka, Owaka, Southland, New Zealand
country: New Zealand
region: Southland
suburb: Owaka
city: Owaka
permalink: /country/new-zealand/southland/owaka/owaka/
---
[↑ Go to Owaka](/country/new-zealand/southland/owaka/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Southland" | where: "suburb", "Owaka" | where: "city", "Owaka" %}
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
