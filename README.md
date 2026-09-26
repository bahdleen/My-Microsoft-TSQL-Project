# European Soccer Leagues — T-SQL Project

Microsoft SQL Server (T-SQL) coursework for **Teesside University**, querying a database of European football leagues across the **2008–2015 seasons**.

**Author:** Anthony Efemena Edjenuwa

## Database

The queries run against a database named `EuroLeagues` with these tables:

| Table | Contents |
| --- | --- |
| `player` | Player names, birthdays, height and weight |
| `player_attributes` | Ratings over time (overall rating, potential, passing, sprint speed, heading accuracy, preferred foot…) |
| `team` / `team_attributes` | Clubs and their attributes |
| `match` | Fixtures: season, stage, date, home/away teams and goals |
| `league` / `country` | Leagues and the countries they belong to |

## What the script covers

All queries are in [`C2548409_Edjenuwa_Anthony_SQL.sql`](C2548409_Edjenuwa_Anthony_SQL.sql), each with comments explaining it.

- **Basic retrieval** — `SELECT`, column selection, `DISTINCT`
- **Joins** — `INNER`, `LEFT`, `RIGHT`, `FULL OUTER` and `CROSS` joins, plus a **self-join** (players with the same height)
- **Multi-table joins** — league → country → match, match → home/away team names
- **Filtering and sorting** — `WHERE`, `LIKE` patterns (e.g. teams starting with `FC`, `Real`, `Manchester`), multi-column `ORDER BY`
- **Paging** — `TOP 10` and skipping the first 10 rows
- **NULL handling** — finding players with no attribute records, `COALESCE`
- **Types and conversion** — `CAST` (integer → float, text → `DATETIME`), `SUBSTRING`
- **Dates and aggregation** — matches per year with `GROUP BY`, date-range filtering
- **Conditional logic** — `CASE` to label results as *Home Win*, *Away Win* or *Draw*
- **Data changes** — `INSERT` (with a `MAX(id) + 1` subquery), `UPDATE`, `DELETE`, and adding an automatic `creation_date` timestamp column

## Running it

1. Restore or create the `EuroLeagues` database in SQL Server.
2. Open the script in SQL Server Management Studio (or Azure Data Studio).
3. Select a query and execute it.

> ⚠️ The script includes statements that **change data** (`INSERT`, `UPDATE`, `DELETE`, schema changes). Run it against a copy of the database.
