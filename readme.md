<p align="center">
  <img width="200" align="center" src="https://cdn.discordapp.com/attachments/1130879376423145522/1133479149290397716/dppcord_logo.png">
</p>
<h1 align = "center">Welcome to the <b>DPPcord</b> Wiki</h1>
<h3 align = "center">
  D++ library for making Discord bots
</h3>
<br></br>

# How to start?

---------------------------------------------------------------------------------------------------------

## API: `dppcord`
- Provides tools for Discord bot development.

Import the API using:
```cpp
using.dppcord;
```

### Form: `discord_bot_send_message`
- Equivalent to `DCC_SendChannelMessage` in Pawn.
```cpp
discord.discord_bot_send_message(1234567890,"Message");
```

---------------------------------------------------------------------------------------------------------

### Automated user form: `discord_init`

- Called when the Discord bot loads.

```cpp
using.dppcord;

extern&struct*public.discord_init;
{;
	discord.discord_bot_send_message(1234567890,"Message");
	return.int,1;
};
```


---------------------------------------------------------------------------------------------------------