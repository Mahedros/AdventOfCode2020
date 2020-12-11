file = open('input.txt')
lines = file.readlines()
file.close()


def part_1(lines):
    passport = {}
    valid_count = 0
    for line in lines:
        if line == '\n':
            if 'byr' in passport and 'iyr' in passport and 'eyr' in passport and 'hgt' in passport and 'hcl' in passport and 'ecl' in passport and 'pid' in passport:
                valid_count += 1
            passport = {}
        tokens = line.strip().split()
        for token in tokens:
            key, value = token.split(':')
            passport[key] = value

    if 'byr' in passport and 'iyr' in passport and 'eyr' in passport and 'hgt' in passport and 'hcl' in passport and 'ecl' in passport and 'pid' in passport:
        valid_count += 1
    return valid_count

def part_2(lines):
    passport = {}
    valid_count = 0
    for line in lines:
        if line == '\n':
            if 'byr' in passport and 'iyr' in passport and 'eyr' in passport and 'hgt' in passport and 'hcl' in passport and 'ecl' in passport and 'pid' in passport:
                 if valid(passport):
                     valid_count += 1
            passport = {}
        tokens = line.strip().split()
        for token in tokens:
            key, value = token.split(':')
            passport[key] = value
    
    if 'byr' in passport and 'iyr' in passport and 'eyr' in passport and 'hgt' in passport and 'hcl' in passport and 'ecl' in passport and 'pid' in passport:
        if valid(passport):
            valid_count += 1
    return valid_count

def valid(passport):
    birth_year = int(passport['byr'])
    issue_year = int(passport['iyr'])
    expire_year = int(passport['eyr'])
    hgt_unit = passport['hgt'][-2:]
    if passport['hgt'][:-2].isnumeric():
        hgt_val = int(passport['hgt'][:-2])
    else:
        return False
    hair = passport['hcl']
    eye = passport['ecl']
    pid = passport['pid']
    
    if birth_year < 1920 or birth_year > 2002:
        return False
    if issue_year < 2010 or issue_year > 2020:
        return False
    if expire_year < 2020 or expire_year > 2030:
        return False
    if hgt_unit not in ('cm', 'in'):
        return False
    if (hgt_unit == 'cm' and (hgt_val < 150 or hgt_val > 193)) or (hgt_unit == 'in' and (hgt_val < 59 or hgt_val > 76)):
        return False
    if hair[0] != '#' or len(hair[1:]) != 6:
        return False
    for char in hair[1:]:
        if char not in {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'}:
            return False
    if eye not in {'amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'}:
        return False
    if len(pid) != 9 or not(pid.isnumeric()):
        return False
    return True

print(part_1(lines))
print(part_2(lines))
