using Microsoft.EntityFrameworkCore;

namespace PizzaStore.Models;

public class Pizza
{
    public int Id { get; set; }
    public string? Name { get; set; }
    public string? Description { get; set; }
}

public class PizzaDb(DbContextOptions<PizzaDb> options)
    : DbContext(options)
{
    public DbSet<Pizza> Pizzas { get; set; } = null!;
}
