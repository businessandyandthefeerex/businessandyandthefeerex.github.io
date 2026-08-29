---
layout: page
title: Hahei, Hahei, Coromandel, New Zealand
country: New Zealand
region: Coromandel
suburb: Hahei
city: Hahei
permalink: /country/new-zealand/coromandel/hahei/hahei/
---
[↑ Go to Hahei](/country/new-zealand/coromandel/hahei/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Coromandel" | where: "suburb", "Hahei" | where: "city", "Hahei" %}
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
