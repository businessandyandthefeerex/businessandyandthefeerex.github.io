---
layout: page
title: Bay of Plenty, New Zealand
region: Bay of Plenty
country: New Zealand
permalink: /country/new-zealand/bay-of-plenty/
---
[⬅ Go up one level](/country/new-zealand/)
<ul>
  {% assign posts = site.posts | where: "region", "Bay of Plenty" | where: "country", "New Zealand" %}
  {% assign grouped_posts = posts | group_by: "suburb" %}

  {% for group in grouped_posts %}
    <h3>{{ group.name }}</h3>

    <!-- Group posts by rating -->
    {% assign rating_groups = group.items | group_by: "rating" %}
    {% assign sorted_rating_groups = rating_groups | sort: "name" %}

    {% for rating_group in sorted_rating_groups reversed %}
      <h4>rating: {{ rating_group.name }}</h4>
      <ul>
        {% for post in rating_group.items %}
          <li>
            <a href="{{ post.url }}">{{ post.title }}</a>
          </li>
        {% endfor %}
      </ul>
    {% endfor %}
  {% endfor %}
</ul>
