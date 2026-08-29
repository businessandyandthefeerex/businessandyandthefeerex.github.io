---
layout: page
title: Feilding, Feilding, Manwatu, New Zealand
country: New Zealand
region: Manwatu
suburb: Feilding
city: Feilding
permalink: /country/new-zealand/manwatu/feilding/feilding/
---
[↑ Go to Feilding](/country/new-zealand/manwatu/feilding/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manwatu" | where: "suburb", "Feilding" | where: "city", "Feilding" %}
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
