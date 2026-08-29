---
layout: page
title: Alexandra, Alexandra, Otago, New Zealand
country: New Zealand
region: Otago
suburb: Alexandra
city: Alexandra
permalink: /country/new-zealand/otago/alexandra/alexandra/
---
[↑ Go to Alexandra](/country/new-zealand/otago/alexandra/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Otago" | where: "suburb", "Alexandra" | where: "city", "Alexandra" %}
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
