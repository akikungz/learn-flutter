import { Elysia, t } from "elysia";
import { swagger } from "@elysiajs/swagger";

import { env } from "@/libs/env";
import { db, schema } from "@/db";
import { eq } from "drizzle-orm";

const app = new Elysia()
  .use(swagger())
  .onBeforeHandle(({ route }) => void console.log(`Request to ${route}`))
  .onAfterHandle((ctx) => console.log(`${ctx.request.method} ${ctx.route} - ${ctx.set.status}`))
  .get("/emp", () => db.select().from(schema.emp))
  .get("/emp/:id", 
    async ({ params, set }) => {
      const res = await db.select()
        .from(schema.emp)
        .where(eq(schema.emp.id, params.id));

      if (res.length === 0) {
        set.status = 404;
        return {
          message: "Not Found",
        }
      }

      set.status = 200;
      return res[0];
    },
    {
      params: t.Object({
        id: t.Number()
      })
    }
  )
  .post("/emp", 
    async ({ body, set }) => {
      const res = await db.insert(schema.emp)
        .values(body)
        .returning();
      
      if (res.length === 0) {
        set.status = 500;
        return {
          message: "Failed to create a new employee",
        }
      }

      set.status = 201;
      return res[0];
    },
    {
      body: t.Object({
        name: t.String(),
        age: t.Number(),
        email: t.String(),
        phone: t.String(),
        address: t.String(),
        weight: t.Number(),
        height: t.Number(),
      })
    }
  )
  .put("/emp/:id",
    async ({ params, body, set }) => {
      const res = await db.update(schema.emp)
        .set(body)
        .where(eq(schema.emp.id, params.id))
        .returning();

      if (res.length === 0) {
        set.status = 500;
        return {
          message: "Failed to update the employee",
        }
      }

      set.status = 200;
      return res[0];
    },
    {
      params: t.Object({
        id: t.Number()
      }),
      body: t.Object({
        name: t.String(),
        age: t.Number(),
        email: t.String(),
        phone: t.String(),
        address: t.String(),
        weight: t.Number(),
        height: t.Number(),
      })
    }
  )
  .delete("/emp/:id",
    async ({ params, set }) => {
      const res = await db.delete(schema.emp)
        .where(eq(schema.emp.id, params.id))
        .returning();

      if (res.length === 0) {
        set.status = 500;
        return {
          message: "Failed to delete the employee",
        }
      }

      set.status = 204;
      return res[0];
    },
    {
      params: t.Object({
        id: t.Number()
      })
    }
  )

app.listen(env.PORT, () => console.log(`Server is running on port ${env.PORT}`));
