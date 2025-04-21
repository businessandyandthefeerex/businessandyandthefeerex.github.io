---
layout: page
title: test region, Australia
region: test region
country: Australia
permalink: /country/australia/test-region/
---
[↑ Go to Australia regions](/country/australia/)
<ul>
  {% assign posts = site.posts | where: "region", "test region" | where: "country", "Australia" %}
  {% assign grouped_posts = posts | group_by: "suburb" %}

  {% for group in grouped_posts %}
    <h4>{{ group.name }}</h4>

    {% assign rating_groups = group.items | group_by: "rating" %}
    {% assign sorted_rating_groups = rating_groups | sort: "name" %}

    {% for rating_group in sorted_rating_groups reversed %}
      <h5>rating: {{ rating_group.name }}</h5>
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
