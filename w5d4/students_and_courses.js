function Student(fname, lname) {
  this.fname = fname,
  this.lname = lname,
  this.courses = []
}

Student.prototype.name = function() {
  return this.fname + " " + this.lname;
}
Student.prototype.enroll = function(course) {
  if (this.courses.indexOf(course) === -1) {
    for (var i = 0; i < this.courses.length; i++) {
      if (this.courses[i].conflicts_with(course)) {
        return;
      }
    }
    this.courses.push(course);
    course.students.push(this);
  }
}
function Course(name, department, credits, block, days) {
  this.name = name,
  this.department = department,
  this.credits = credits,
  this.block = block,
  this.days = days,
  this.students = []
}
Course.prototype.add_student = function(student) {
  student.enroll(this);
}
Student.prototype.course_load = function() {
  dept_credits = {}
  for (var i = 0; i < this.courses.length; i++) {
    if (this.courses[i].department in dept_credits) {
      dept_credits[this.courses[i].department] += this.courses[i].credits;
      // increment by this.courses[i].credits
    } else {
      dept_credits[this.courses[i].department] = this.courses[i].credits;
    }
  }
  return dept_credits;
}
Course.prototype.conflicts_with = function(course) {
  if (this.block == course.block) {
    for (var i = 0; i < this.days.length; i++) {
      if (course.days.indexOf(this.days[i]) !== -1) {
        return true;
      }
    }
  }
  return false;
}

var mary = new Student("mary", "smith");
var english_course = new Course("english 101", "English", 3, 2, ["Mon", "Tues"]);
var english_course2 = new Course("english 201", "English", 4, 2, ["Mon", "Wed"]);
var math_course = new Course("english 101", "Math", 2, 3, ["Mon", "Tues"]);

mary.enroll(english_course);
mary.enroll(english_course2);
mary.enroll(math_course);

console.log(mary.course_load());
