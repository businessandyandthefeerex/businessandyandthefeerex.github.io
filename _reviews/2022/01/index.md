---
layout: page
title: "Reviews from January 2022"
permalink: /reviews/2022/01/
year: 2022
month: 01
---
[↑ Go to 2022](/reviews/2022/)

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
