---
layout: page
title: "Reviews from 2022"
permalink: /reviews/2022/
year: 2022
---
[↑ Go to all reviews](/reviews/)

{% assign this_year = page.year | plus: 0 %}
{% assign sorted_posts = site.posts | sort: "date" | reverse %}
{% assign current_month = "" %}
{% assign first_loop = true %}

{% for post in sorted_posts %}
{% assign review_year = post.date | date: "%Y" | plus: 0 %}
{% if review_year == this_year %}
{% assign post_month = post.date | date: "%B" %}
{% if post_month != current_month %}
{% unless first_loop %}
</ul>
{% endunless %}
<h4>{{ post_month }}</h4>
<ul>
{% assign current_month = post_month %}
{% assign first_loop = false %}
{% endif %}
<li><a href="{{ post.url }}">{{ post.title }}</a></li>
{% endif %}
{% endfor %}
</ul>
