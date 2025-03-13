using System;
using Godot;

public partial class Player : CharacterBody2D
{
	[Export]
	public float maxSpeed { get; set; } = 100;

	[Export]
	public float acceleration { get; set; } = 20;

	[Export]
	public int friction { get; set; } = 30;
	private AnimatedSprite2D playerAnimation;

	public override void _Ready()
	{
		playerAnimation = GetNode<AnimatedSprite2D>("Farmer");
	}

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
		if (Velocity.Length() > 0)
		{
			var ap = GetNode("Farmer") as AnimationPlayer;
			ap.Play("idle");
		}
		else
		{
			playerAnimation.Play("idle");
		}
	}
}
