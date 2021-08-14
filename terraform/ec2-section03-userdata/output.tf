output "instance" {
  value = "${aws_instance.t2-nano-inst.public_ip}"
}