using System;
using Godot;

public partial class Player : CharacterBody2D
{
	[Export]
	public float maxSpeed { get; set; } = 400;

	[Export]
	public float acceleration { get; set; } = 20;

	[Export]
	public int friction { get; set; } = 30;

	public void GetInput()
	{
		Vector2 inputDirection = Input.GetVector("left", "right", "up", "down");
		Vector2 v = Velocity;
		v.Y = Mathf.MoveToward(Velocity.Y, inputDirection.Y * maxSpeed, acceleration);

		v.X = Mathf.MoveToward(Velocity.X, inputDirection.X * maxSpeed, acceleration);
		Velocity = v;
	}

	public override void _PhysicsProcess(double delta)
	{
		base._PhysicsProcess(delta);
		GetInput();
		MoveAndSlide();
	}
}
