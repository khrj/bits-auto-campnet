import "@std/dotenv/load"

const CAPTIVE_URL = (ts: number) => `http://captive.apple.com/?ts=${ts}`
const SUCCESS_STRING =
	"<HTML><HEAD><TITLE>Success</TITLE></HEAD><BODY>Success</BODY></HTML>"
const LOGIN_URL = "https://campnet.bits-goa.ac.in:8090/login.xml"

const username = Deno.env.get("SOPHOS_USERNAME")
const password = Deno.env.get("SOPHOS_PASSWORD")

if (!username) {
	console.error("No username. Set SOPHOS_USERNAME in .env ")
	Deno.exit(1)
}

if (!password) {
	console.error("No password. Set SOPHOS_PASSWORD in .env")
	Deno.exit(1)
}

const sleep = (ms: number) => new Promise(res => setTimeout(res, ms))

while (true) {
	console.log("Checking...")

	const resp = await fetch(CAPTIVE_URL(Date.now()), {
		signal: AbortSignal.timeout(1000),
	})
		.then(r => r.text())
		.catch(_ => "failed")

	if (resp.trim() !== SUCCESS_STRING) {
		console.info("Not logged in.")
		await fetch(LOGIN_URL, {
			method: "POST",
			headers: {
				"Content-Type": "application/x-www-form-urlencoded",
			},
			body: new URLSearchParams({
				mode: "191",
				producttype: "0",
				username,
				password,
			}),
		})
			.then(response => {
				if (response.status === 200)
					console.info("Logged in successfully")
				else
					response
						.text()
						.then(text =>
							console.error(`Error during login: ${text}`)
						)
			})
			.catch(err => console.error(err))
	} else {
		console.log("OK")
	}

	await sleep(5000)
}
