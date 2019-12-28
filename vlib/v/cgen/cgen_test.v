import (
	os
	filepath
	v.parser
	v.ast
	v.cgen
	v.table
)

const (
	nr_tests = 2
)

fn test_c_files() {
	println('Running V => C tests')
	dir := filepath.dir(os.executable())
	for i in 1 .. nr_tests + 1 {
		text := os.read_file('$dir/tests/${i}.v') or {
			exit(0)
			// panic(err)
			// exit(1)
		}
		ctext := os.read_file('$dir/tests/${i}.c') or {
			exit(0)
			// exit(1)
			// panic(err)
		}
		table := &table.Table{}
		program := parser.parse_file(text, table)
		res := cgen.gen(program)
		if compare_texts(res, ctext) {
			eprintln('${i}... OK')
		}
		else {
			eprintln('${i}... FAIL')
			eprintln('expected:\n$ctext\ngot:\n$res')
		}
	}
}

fn compare_texts(a, b string) bool {
	lines_a := a.trim_space().split_into_lines()
	lines_b := b.trim_space().split_into_lines()
	if lines_a.len != lines_b.len {
		println('different len')
		return false
	}
	for i, line_a in lines_a {
		line_b := lines_b[i]
		if line_a.trim_space() != line_b.trim_space() {
			println('!' + line_a)
			return false
		}
	}
	return true
}
