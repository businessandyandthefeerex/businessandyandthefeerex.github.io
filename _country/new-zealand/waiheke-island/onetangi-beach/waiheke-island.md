---
layout: page
title: Waiheke Island, Onetangi Beach, Waiheke Island, New Zealand
country: New Zealand
region: Waiheke Island
suburb: Onetangi Beach
city: Waiheke Island
permalink: /country/new-zealand/waiheke-island/onetangi-beach/waiheke-island/
---
[↑ Go to Onetangi Beach](/country/new-zealand/waiheke-island/onetangi-beach/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Waiheke Island" | where: "suburb", "Onetangi Beach" | where: "city", "Waiheke Island" %}
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
