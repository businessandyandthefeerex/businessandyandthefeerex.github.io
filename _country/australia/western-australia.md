---
layout: page
title: Western Australia, Australia
country: Australia
region: Western Australia
permalink: /country/australia/western-australia/
---
[↑ Go to Australia regions](/country/australia/)
<ul>
  {% assign posts = site.posts | where: "region", "Western Australia" | where: "country", "Australia" %}
  {% assign grouped_posts = posts | group_by: "suburb" %}

  {% assign sorted_grouped_posts = grouped_posts | sort: "name" %}
  {% for group in sorted_grouped_posts %}

    {% assign suburb_slug = group.name | downcase | slugify %}
    <h4><a href="/country/australia/western-australia/{{ suburb_slug }}" style="color: var(--heading-color);">{{ group.name }}</a></h4>

    {% assign rating_groups = group.items | group_by: "rating" %}
    {% assign sorted_rating_groups = rating_groups | sort: "name" %}

    {% for rating_group in sorted_rating_groups reversed %}
      <h5>Rating: {{ rating_group.name }}</h5>
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
