file = open('input.txt')
lines = file.readlines()
file.close()

def part_1(lines):
    questions = set()
    total = 0
    for line in lines:
        if line == '\n':
            total += len(questions)
            questions = set()
        for char in line.strip():
            questions.add(char)

    total += len(questions)
    return total

def part_2(lines): 
    sets = []
    total = 0
    for line in lines:
        if line == '\n':
            intersect_set = set.intersection(*sets)
            total += len(intersect_set)
            sets = []
            continue
        line_set = set()
        for char in line.strip():
            line_set.add(char)
        sets.append(line_set)
    intersect_set = set.intersection(*sets)
    total += len(intersect_set)
    return total

print(part_1(lines))
print(part_2(lines))
