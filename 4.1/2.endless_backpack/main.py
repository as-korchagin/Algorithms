def get_max_cost(*args):
    # args[0] is items count
    # args[1] is backpack capacity
    items = sorted(list([*(map(int, input().split()))] for _ in range(args[0])), key=lambda x: x[0] / x[1],
                   reverse=True)
    capacity_left = args[1]
    total_price = 0
    while capacity_left > 0 and len(items) > 0:
        # item[0] is price
        # item[1] is volume
        item = items.pop(0)
        if capacity_left - item[1] >= 0:
            capacity_left -= item[1]
            total_price += item[0]
        else:
            total_price += item[0] / item[1] * capacity_left
            capacity_left = 0
    return total_price


print(get_max_cost(*list(map(int, input().split()))))
