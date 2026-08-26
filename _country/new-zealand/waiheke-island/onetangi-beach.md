---
layout: page
title: Onetangi Beach, Waiheke Island, New Zealand
country: New Zealand
region: Waiheke Island
suburb: Onetangi Beach
permalink: /country/new-zealand/waiheke-island/onetangi-beach/
---
[↑ Go to Waiheke Island](/country/new-zealand/waiheke-island/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Waiheke Island" | where: "suburb", "Onetangi Beach" %}
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
