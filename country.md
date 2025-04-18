---
title: Countries
permalink: /country/
---
[⬅ Go to the Browse by Region page](/region/)

{% assign reviews = site.categories.reviews %}
{% assign countries = "" | split: "" %}

{% for post in reviews %}
  {% unless countries contains post.country %}
    {% assign countries = countries | push: post.country %}
  {% endunless %}
{% endfor %}

<ul>
  {% assign sorted_countries = countries | sort %}
  {% for country in sorted_countries %}
    <li>
      <a href="/country/{{ country | downcase | replace: ' ', '-' }}/">{{ country }}</a>
    </li>
  {% endfor %}
</ul>