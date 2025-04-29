---
layout: page
title: "Reviews from February 2025"
permalink: /reviews/2025/02/
year: 2025
month: 02
---
[↑ Go to 2025](/reviews/2025/)

{% assign this_year = page.year | plus: 0 %}
{% assign this_month = page.month | plus: 0 %}
<ul>
    {% for post in site.posts %}
        {% assign review_year = post.date | date: "%Y" | plus: 0 %}
        {% assign review_month = post.date | date: "%m" | plus: 0 %}
        {% if review_year == this_year and review_month == this_month %}
            <li><a href="{{ post.url }}">{{ post.title }}</a></li>
        {% endif %}
    {% endfor %}
</ul>
